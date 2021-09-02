require 'csv'

SCHEDULER.every '10s' do |job|
  points = {}
  CSV.foreach('data/diet.csv', headers: %w[day calories], converters: :numeric) do |row|
    points[row['day']] = row['calories']
  end
  send_event('bar-chart', {
               labels: points.keys,
               datasets: points.values
             })
end
