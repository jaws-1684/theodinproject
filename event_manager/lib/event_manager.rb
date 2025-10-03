require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phonenumber(homephone)
  homephone.gsub!(/[^\d]/, '')

  if homephone.length == 10
    homephone
  elsif homephone.length == 11 && homephone[0] == "1"
    homephone[1..10]
  else
    "Wrong Number!!"
  end
end

def get_time(time)
  date = DateTime.strptime(time, "%m/%d/%y %H:%M")
  date.hour
end

def get_wday(day)
	date = DateTime.strptime(day, "%m/%d/%y %H:%M")
	date.wday
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('secret.key').strip

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."
puts "\n"


contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

registration_hours = []
registration_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phonenumber = clean_phonenumber(row[:homephone])

  time = get_time(row[:regdate])
  	registration_hours.push(time)
  day = get_wday(row[:regdate])
  	registration_days.push(day)
  

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

peak_hours = registration_hours.tally.sort_by { |hour, count| -count }
peak_days = registration_days.tally.sort_by {|day, count| -count}

puts "Peak Registration Hours:"

peak_hours.each do |hour, count|
  puts "Hour: #{hour}:00, Registrations: #{count}"
end

puts "\n"

day_names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

puts "Peak Registration Days:"
peak_days.each do |day, count|
  puts "Day: #{day_names[day]}, Registrations: #{count}"
end
