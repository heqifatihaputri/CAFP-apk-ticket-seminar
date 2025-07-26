# frozen_string_literal: true

module Modules
  module GivenParamsFileable
    extend ActiveSupport::Concern

    def given_params
      if params[:image].present?
        set_given_params

        number = params[resource_name_sym][:images_attributes].keys.last.to_i rescue 0
        JSON.parse(params[:image]).each do |data|
          params[resource_name_sym][:images_attributes]["#{number+=1}"] = { image: data.to_json }
        end
      end

      super
    end

    def set_given_params
      params[resource_name_sym][:images_attributes] = {} if params[resource_name_sym][:images_attributes].blank?
    end

    def resource_name_sym
      self.class.name.gsub('Controller', '').split('::').last.underscore.singularize.to_sym
    end
  end
end
