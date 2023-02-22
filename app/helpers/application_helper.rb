module ApplicationHelper
  def allowed_modules
    return [] unless current_user

    modules = [projects_path]
    modules << users_path if policy(:user).index?
    modules
  end

  def status_cls(status)
    case status
    when 'created'
      'primary'
    when 'in_progress'
      'warning'
    when 'completed'
      'danger'
    else
      'success'
    end
  end
end
