namespace :forecast do
  desc "compare dates"
  task :compare_dates do
    puts "Date.today = #{Date.today}"
    puts "Date.current = #{Date.current}"
  end
end
