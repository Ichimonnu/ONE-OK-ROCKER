module ApplicationHelper
    module I18nHelper
        def i18n_delete_default_value(button)
        object = convert_to_model(form.object)
        key = object ? (object.persisted? ? :update : :create) : :delete
        model = if object.respond_to?(:model_button)
            object.model_name.human
        else
            form.object_name.to_s.humanize
        end
            defaults = []
            defaults << :"helpers.delete.#{form.object_name}.#{key}"
            defaults << :"helpers.delete.#{key}"
            defaults << "#{key.to_s.humanize} #{model}"
            I18n.t(defaults.shift, model: model, default: defaults)
        end
    end

    module I18nHelper
        def i18n_submit_default_value(form)
            object = convert_to_model(form.object)
            key = object ? (object.persisted? ? :update : :create) : :submit
        
            model = if object.respond_to?(:model_name)
            object.model_name.human
            else
            form.object_name.to_s.humanize
        end
        
            defaults = []
            defaults << :"helpers.submit.#{form.object_name}.#{key}"
            defaults << :"helpers.submit.#{key}"
            defaults << "#{key.to_s.humanize} #{model}"
            I18n.t(defaults.shift, model: model, default: defaults)
        end
    end
end