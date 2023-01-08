module ApplicationHelper

  FLASH_NAMES = {
    'notice' => 'info',
    'success' => 'success',
    'error' => 'warning',
    'alert' => 'danger'
  }.freeze

  def self.all_constructions
    Construction.all
  end

  def self.link_to_previous_page(link_title)
    link_to_if
  end

  def self.flash_class(name)
    FLASH_NAMES[name]
  end
end
