module ApplicationHelper
  def allowed_modules
    modules = [{ title: t('modules.projects'), path: projects_path }]
    modules << { title: t('modules.users'), path: users_path } if policy(:user).index?
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

  def module_is_active?(path)
    request.path =~ /#{path}/
  end
end
