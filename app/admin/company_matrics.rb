ActiveAdmin.register_page "Company Metrics" do
	menu priority: 5

	content title: "Company Matrics" do

		columns do
	        column do
	            panel "User Active / Deactive" do
	                pie_chart User.group(:status).count
	            end
	        end
	    end

	    columns do
	        column do
	            panel "User Registration" do
	                line_chart User.group_by_day(:created_at, time_zone: "Pacific Time (US & Canada)").count
	            end
	        end
	    end

	    columns do
	        column do
	            panel "User Visits" do
	                line_chart Visit.group_by_day(:started_at).count
	            end
	        end
	    end

	end
end