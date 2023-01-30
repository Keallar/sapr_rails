module ApplicationHelper

  FLASH_NAMES = {
    'notice' => 'info',
    'success' => 'success',
    'error' => 'warning',
    'alert' => 'danger'
  }.freeze

  def all_constructions
    Construction.all
  end

  def flash_class(name)
    FLASH_NAMES[name]
  end

  def exist_or_new_constr_url(constr)
    if !constr&.id.nil?
      preprocessor_path(constr)
    else
      new_preprocessor_path
    end
  end
end
