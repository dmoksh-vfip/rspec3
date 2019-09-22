module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)
  class Ledger
    def record(expense)
      unless expense.key?(:payee)
        message = 'Invalid expense: `payee` is required'
        return RecordResult.new(false, nil, message)
      end
      DB[:expenses].insert(expense)
      id= DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end
  end
end