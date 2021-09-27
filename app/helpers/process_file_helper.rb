module ProcessFileHelper

		def message_for(user)
			if user.errors
				(user.errors.full_messages + [user.correction_message]).join("<br>")
			else
				"this user was imported successfully #{user.name}"
			end
		end
end
