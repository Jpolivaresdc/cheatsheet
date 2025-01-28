require 'date'

def days_360_until start_date, end_date
  return -days_360_until(end_date, start_date) if end_date < start_date
  return 0 if end_date == start_date

  dif_months = months_until(end_date, start_date)
  tmp = start_date >> dif_months # Shift months
  remainder = (end_date - tmp).to_i.clamp(0, 30)

  dif_months * 30 + remainder
end

def months_until end_date, start_date
  return 0 if start_date >= end_date

  diff = 0
  current_month = start_date
  while current_month.next_month <= end_date
    diff += 1
    current_month = current_month.next_month
  end
  diff
end

if ARGV.length != 2
  puts "Usage: ruby calculate_days.rb <start_date> <end_date>"
  exit
end

start_date = ARGV[0] == "today" ? Date.today : Date.parse(ARGV[0])
end_date = ARGV[1] == "today" ? Date.today : Date.parse(ARGV[1])

days = days_360_until(start_date, end_date)
legal_days = (days / 360.0) * 15.0

puts "----------------------------------"
puts "Fecha inicial: #{start_date}"
puts "Fecha final: #{end_date}"
puts "Días: #{days}"
puts "Meses: #{months_until(end_date, start_date)}"
puts "Días legales: #{legal_days.round(4)}"
puts "----------------------------------"
