class User < ApplicationRecord
	require 'csv'

	validates :name,
          	presence: true

	validates :password,
						presence: true
	validate :has_required_characters
	validate :not_have_repeated_characters
	validate :length_of_password
	MIN_PASSWORD_LENGTH = 10
	MAX_PASSWORD_LENGTH = 16
	def self.import(file)
		users = []
		CSV.foreach(file.path, headers: true) do |row|
			user = User.new(row.to_hash)
			user.save
			users << user
		end
		users
	end

	def length_of_password
		if password.length < MIN_PASSWORD_LENGTH
			errors.add(:password, 'length must be #{MIN_PASSWORD_LENGTH} or more')
			@length_less_by = MIN_PASSWORD_LENGTH - password.length
		end
		if password.length > MAX_PASSWORD_LENGTH
			errors.add(:password, 'length must be #{MAX_PASSWORD_LENGTH} or less')
			@length_more_by = password.length - MAX_PASSWORD_LENGTH
		end

	end

	def has_required_characters
	 @single_violation = 0
		unless password.match(/[A-Z]/)
			errors.add(:password, 'Must contain uppercase character')
			@single_violation += 1
		end
		unless password.match(/[a-z]/)
			errors.add(:password, 'Must contain lowercase character')
			@single_violation += 1
		end
		unless password.match(/[0-9]/)
			errors.add(:password, 'Must contain digit')
			@single_violation += 1
		end
	end

	def correction_message
		"Change #{count_of_corrections} #{maybe_pluralize('character', count_of_corrections)} of #{name}'s password"
	end

	def maybe_pluralize(string, count)
		count == 1 ? string : string + 's'
	end

	def count_of_corrections
		sum = 0
		if @length_less_by.to_i > 0
			sum = [@length_less_by, @single_violation.to_i].max
		else
			sum = @length_more_by.to_i + @single_violation.to_i
		end
		sum + @repeated_errors_count
	end

	def not_have_repeated_characters
		length = password.length
		@repeated_errors_count = 0
		0.upto length-2 do |index|
			if password[index..index+2].scan(/./).uniq.length == 1
				@repeated_errors_count += 1
				errors.add(:password, 'has repeated characters')
			end
		end
	end
end
