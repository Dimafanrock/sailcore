require 'securerandom'

SEED_PASSWORDS_FILE = Rails.root.join('db/seed_passwords.txt')

# Ensure the file exists before truncating
File.write(SEED_PASSWORDS_FILE, '') unless File.exist?(SEED_PASSWORDS_FILE)

# Utility method to generate & store password
def generate_password_for(user_type)
  password = SecureRandom.base58(24)
  File.open(SEED_PASSWORDS_FILE, 'a') do |file|
    file.puts "#{user_type.capitalize} Password: #{password}"
  end
  password
end

# Clear the file before writing new passwords
File.truncate(SEED_PASSWORDS_FILE, 0)

# Create Admin (Morpheus)
admin = Admin.find_or_initialize_by(name: 'Morpheus', email: 'admin@gmail.com')
admin.password = generate_password_for('admin')
admin.password_confirmation = admin.password
admin.image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/images/Morpheus.png'), 'image/png')
admin.save!

# Create Client (Mr. Smith)
client = Client.find_or_initialize_by(name: 'Mr. Smith', email: 'client@gmail.com')
client.password = generate_password_for('client')
client.password_confirmation = client.password
client.image = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/images/Mr.Smith.png'), 'image/png')
client.save!

Rails.logger.debug "✅ Seeding complete! Check 'db/seed_passwords.txt' for generated passwords."
