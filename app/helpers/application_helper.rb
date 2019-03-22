# frozen_string_literal: true

module ApplicationHelper
  def page_title(title)
    title += ' | ' if title.present?
    title += 'TLC Directory'
  end

  # pass prefixes to views
  def name_prefixes
    I18n.t('names.prefix')
  end

  # pass suffixes to views
  def name_suffixes
    I18n.t('names.suffix')
  end

  # us states
  def us_states
    abbr = I18n.t('address.state_abbr')
    states = I18n.t('address.state')
    Hash[abbr.zip(states)]
  end

  # logged in user
  def logged_in?
    !!(session['cas'] && session['cas']['user'])
  end

  # get current user for views
  def current_user
    User.where(wvu_username: session['cas']['user']) if logged_in?
  end

  # dynamically add fieldsets
  # setup from rails casts
  def link_to_add_fields(name, form, association)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, form: builder)
    end
    link_to(name, '#', class: 'add-fields', data: { id: id, fields: fields.delete("\n") })
  end

  # phone logic helper
  def phone_icon_class(phone)
    if phone.number_types == 'fax'
      'fas fa-fax'
    else
      'fas fa-mobile-alt'
    end
  end
end
