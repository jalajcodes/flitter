module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Flitter'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def button_title
    edit_page ? 'Save Chnages' : 'Sign Up'
  end
end
