# frozen_string_literal: true

class ArrayLength < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params)
    unless params[attr_name].size <= @option
      raise Grape::Exceptions::Validation.new params: [@scope.full_name(attr_name)],
                                              message: "must be maximum #{@option} items"
    end
  end
end
