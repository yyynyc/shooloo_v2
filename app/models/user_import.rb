class UserImport 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value)}
  end

  def persisted?
    false
  end

  def save(current_user_id)
    @imported_users = load_imported_users(current_user_id)
    begin 
      @imported_users.each do |user|
        user.visible = true
        user.save!
        Authorization.create!(authorized_id: user.id, authorizer_id: current_user_id, approval: "accepted")
      end
      return true
    rescue
     @imported_users.each_with_index do |user, index|
       user.errors.full_messages.each do |message|
        errors.add :base, "Row #{index+2}: #{message}"
        end
      end
     return false
    end
  end

  def load_imported_users(current_user_id)
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
      imported_users = []
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        user = User.new
        user.attributes = row.to_hash.slice(*User.accessible_attributes)
        #user.save!
        imported_users << user
        #Authorization.create!(authorized_id: user.id, authorizer_id: current_user_id, approval: "accepted")
      end
      # Need to return an array of users not 2..2
      imported_users
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
