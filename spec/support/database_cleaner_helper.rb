module DatabaseCleanerHelper
  def clean_with_transaction_on(target)
    database_cleaner :transaction, target
  end

  def clean_with_truncate_on(target)
    database_cleaner :truncate, target
  end

  def database_cleaner(strategy, target)
    before(target) do
      DatabaseCleaner.strategy = strategy
      DatabaseCleaner.start
    end

    after(target) do
      DatabaseCleaner.clean
    end
  end
end
