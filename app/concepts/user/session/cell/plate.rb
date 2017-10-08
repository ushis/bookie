require_dependency 'bookie/cell'

class User < ApplicationRecord
  module Session
    module Cell
      class Plate < Bookie::Cell
        property :user_agent
        property :ip_address

        private

        def active?
          model == current_session
        end

        def bulp
          content_tag(:span, nil, class: active? ? %w(bulp info) : %w(bulp))
        end

        def icon
          if ua.device.mobile? || ua.device.tablet?
            octicon('device-mobile')
          else
            octicon('device-desktop')
          end
        end

        def browser
          ua.name.try(:titleize)
        end

        def platform
          ua.platform.to_s.try(:titleize)
        end

        def created_at
          I18n.l(model.created_at, format: '%B %d, %Y')
        end

        def ua
          @ua ||= Browser.new(model.user_agent)
        end

        def show_button_to_revoke?
          !active?
        end

        def button_to_revoke
          link_to('Revoke', settings_security_session_path(model), {
            class: 'button is-small',
            method: 'delete',
          })
        end
      end
    end
  end
end
