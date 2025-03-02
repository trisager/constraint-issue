defmodule Bella.Bookings do
  use Ash.Domain,
    otp_app: :bella

  resources do
    resource Bella.Bookings.Booking do
      define :create_booking, action: :create
    end
  end
end
