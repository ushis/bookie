namespace :es do
  namespace :indices do
    desc 'creates all configured elasticsearch indices'
    task create: :environment do
      Bookie::Search.create_indices
    end
  end
end
