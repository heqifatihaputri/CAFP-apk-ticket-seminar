# frozen_string_literal: true

module Modules
  module Crudable
    extend ActiveSupport::Concern

    included do
      class_attribute :additional_parameters
      class_attribute :model_resource
      class_attribute :redirect_path
      class_attribute :render_action
      class_attribute :resource_action
      class_attribute :resource_loads
      class_attribute :resources_action
      class_attribute :resources_query
      class_attribute :order_field

      self.additional_parameters = []
      self.resource_action       = %w[new show create edit update destroy]
      self.resource_loads        = {}
      self.resources_action      = %w[index export]
      self.resources_query       = {}
      self.redirect_path         = nil
      self.render_action         ||= :new
      self.order_field           ||= {created_at: :desc}

      before_action :build_resource
    end

    def index
      yield if block_given?

      respond_to do |format|
        format.html
        format.json { render json: resources, status: :ok }
        format.js
      end
    end

    def new
      yield if block_given?

      respond_to do |format|
        format.html
        format.json { render json: resource, status: :ok }
        format.js
      end
    end

    def create
      yield if block_given?

      respond_to do |format|
        if resource.save
          flash[:notice] ||= "#{resource_name('string')} successfully created."
          format.html { redirect_to build_redirect_path }
          format.json { render json: resource, status: :created }
        else
          format.html { render render_action }
          format.json { render json: errors, status: :unprocessable_entity }
        end
        format.js
      end
    end

    def show
      yield if block_given?

      respond_to do |format|
        format.html
        format.json { render json: resource, status: :ok }
        format.js
      end
    end

    def edit
      yield if block_given?

      respond_to do |format|
        format.html
        format.json { render json: resource, status: :ok }
        format.js
      end
    end

    def update
      yield if block_given?
      respond_to do |format|
        if resource.update(given_params)
          flash[:notice] ||= "#{resource_name('string')} successfully updated."
          format.html { redirect_to build_redirect_path }
          format.json { render json: resource, status: :ok }
        else
          format.html { render :edit }
          format.json { render json: errors, status: :unprocessable_entity }
        end
        format.js
      end
    end

    def destroy
      yield if block_given?
      if resource.destroy
        flash[:notice] ||= "#{resource_name('string')} successfully destroyed."
      else
        message = resource.errors.full_messages.to_sentence rescue nil
        flash[:alert] ||= message ? message : "Failed to delete."
      end

      respond_to do |format|
        format.html { redirect_to build_redirect_path }
        format.json { render json: resource, status: :ok }
        format.js
      end
    end

    private

    def resource
      get_variable(resource_name)
    end

    def resources
      get_variable(resources_name)
    end

    def build_resource
      if mine.resources_action.include?(action_name)
        set_variable(resources_name, eager_loaded_model.all.order(order_field))
      elsif mine.resource_action.include?(action_name)
        set_variable(resource_name, set_resource)
      end
    end

    def take_id
      params[:id] || params["#{resource_name}_id"]
    end

    def get_variable(name)
      instance_variable_get("@#{name}")
    end

    def build_redirect_path
      target_path = mine.redirect_path || redirect_path
      return target_path if target_path.present?
      return polymorphic_url([current_controller_path.to_sym, model]) if %w[destroy export].include?(action_name)

      polymorphic_url([current_controller_path.to_sym, resource])
    end

    def set_variable(name, value = nil)
      instance_variable_set("@#{name}", value)
    end

    def set_resource
      return model.new(given_params) if %w[new create].include?(action_name)
      return eager_loaded_model.friendly.find(take_id) if model.respond_to?(:friendly)

      eager_loaded_model.find(take_id)
    end

    def given_params
      yield if block_given?
      begin
        params.require(resource_name).permit(model.column_names, mine.additional_parameters)
      rescue StandardError
        {}
      end
    end

    def model
      eval(resource_name.to_s.camelize)
    end

    def eager_loaded_model
      if resources_query.present? && resources_action.include?(action_name)
        return model.eager_load(mine.resource_loads).where(resources_query)
      end

      model.eager_load(mine.resource_loads)
    end

    def resource_name(return_format = 'sym')
      mine.model_resource ||= mine.name.gsub('Controller', '').split('::').last.underscore.singularize.to_sym
      return mine.model_resource.to_s.humanize if return_format.eql?('string')

      mine.model_resource
    end

    def resources_name
      resource_name.to_s.pluralize
    end

    def mine
      self.class
    end
  end
end
