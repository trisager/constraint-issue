defmodule Bella.Bookings.Booking do
  use Ash.Resource, otp_app: :bella, domain: Bella.Bookings, data_layer: AshPostgres.DataLayer

  postgres do
    table "bookings"
    repo Bella.Repo

    exclusion_constraint_names [{:bella, "bookings_cannot_overlap", "overlap error"}]

    custom_statements do
      statement :bookings_cannot_overlap do
        up """
        ALTER TABLE bookings
        ADD CONSTRAINT bookings_cannot_overlap
        EXCLUDE USING gist (
          box(
            point(
              extract( epoch from start ), user_id
            ),
            point(
              extract( epoch from start ) + duration - 1,
              user_id + 0.5
            )
          )
          WITH &&
        )
        """

        down """
        ALTER TABLE bookings
        DROP CONSTRAINT bookings_cannot_overlap
        """
      end
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:start, :duration, :user_id]
    end
  end

  attributes do
    integer_primary_key :id

    attribute :start, :naive_datetime do
      allow_nil? false
    end

    attribute :duration, :integer do
      allow_nil? false
    end

    attribute :user_id, :integer do
      allow_nil? false
    end

    create_timestamp :inserted_at
  end
end
