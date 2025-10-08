module ApplicationHelper
  def flash_message_class(message_type)
    case message_type
    when 'success'
      'text-green-800 bg-green-50 border border-green-300'
    when 'danger', 'alert', 'error'
      'text-red-800 bg-red-50 border border-red-300'
    when 'warning'
      'text-yellow-800 bg-yellow-50 border border-yellow-300'
    when 'notice', 'info'
      'text-blue-800 bg-blue-50 border border-blue-300'
    else
      'text-gray-800 bg-gray-50 border border-gray-300'
    end
  end
end
