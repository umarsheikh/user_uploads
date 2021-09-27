module ProcessFileHelper

		def message_for(user)
			if user.errors.present?
				user.correction_message
			else
				"#{user.name} was successfully saved"
			end
		end
end
