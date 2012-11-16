module DatabaseCleanerHelper
  def clean_with_transaction_on(target)
    databse_cleaner :transaction, target
  end

  def clean_with_truncate_on(target)
    databse_cleaner :truncate, target
  end

  def databse_cleaner(strategy, target)
    before(target) do
      DatabaseCleaner.strategy = strategy
      DatabaseCleaner.start
    end

    after(target) do
      DatabaseCleaner.clean
    end
  end
end