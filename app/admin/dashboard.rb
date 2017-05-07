ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
        column do
            panel "Recent Active Users" do
                table_for User.active.order('id desc').limit(5) do
                    column("Full Name") {|name| name.full_name}
                    column("E-mail") {|email| email.email}
                    column("Role") {|role| status_tag(role.role, :agent)}
                    column("Status") {|status| status_tag(status.status, :ok)}
                end
            end
        end
    end

    columns do
        column do
            panel "Recent Deactivate Users" do
                table_for User.deactivate.order('id desc').limit(5) do
                    column("Full Name") {|name| name.full_name}
                    column("E-mail") {|email| email.email}
                    column("Role") {|role| status_tag(role.role, :agent)}
                    column("Status") {|status| status_tag(status.status, :red)}
                    column("Action") {|link| link_to("View", admin_user_path(link), class: "member_link") }
                end
            end
        end
    end

    columns do
        column do
            panel "Recent Tasks" do
                table_for Task.order('id desc').limit(5) do
                    column("Task") {|task| task.todo}
                    column("Date") {|date| date.expire}
                    column("Published") {|published| published.published}
                    column("Finished") {|finished| finished.finished}
                    column("User") {|user| link_to(user.user.full_name, admin_user_path(user.user), class: "member_link")}
                    column("Action") {|link| link_to("View", admin_task_path(link), class: "member_link") }
                end
            end
        end
    end

    # section "Recent Users" do
    #     table_for User.order("created_at desc").limit(5) do
    #       column :full_name
    #       column :email
    #       column "Registration Date", :created_at
    #     end
    #     strong { link_to "All Users", admin_users_path }
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
