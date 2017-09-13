module Bookie
  class Cell < Trailblazer::Cell
    class Layout < Cell
      class Navigation < Cell

        private

        def brand
          link_to('Bookie', root_path, class: 'navbar-brand')
        end

        def search_url
          root_path
        end

        def search_query
          context[:q]
        end

        def show_link_to_lookup?
          Book::Guard::Lookup.(current_user: current_user)
        end

        def link_to_lookup
          link_to('Add book', lookup_books_path)
        end

        def show_link_to_sign_in?
          !current_user.present?
        end

        def link_to_sign_in
          link_to('Sign in', sign_in_path)
        end

        def show_user_menu?
          current_user.present?
        end

        def link_to_profile
          link_to('Profile', '#')
        end

        def link_to_sign_out
          link_to('Sign out', sign_out_path, method: :delete)
        end

        def username
          current_user.username
        end

        def avatar
          concept('user/cell/avatar', current_user, version: :tiny)
        end
      end
    end
  end
end
