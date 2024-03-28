class Quote < ApplicationRecord
    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # after_create_commit -> {
    #     broadcast_prepend_later_to "quotes" # broadcast to users subscribed to the quotes stream and prepend to DOM node with id "quotes"
    #     # partial: "quotes/quote", # default is equal to calling to_partial_path on a model instance, which is the example to the left
    #     # locals: { quote: self }, # default value is equal to { model_name.element.to_sym => self }
    #     # target: "quotes" # default target is model_name.plural
    # }
    # after_update_commit -> { broadcast_replace_later_to "quotes" }
    # after_destroy_commit -> { broadcast_remove_to "quotes" } # remove does not have an async/later counterpart as the record is deleted from the db

    broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
