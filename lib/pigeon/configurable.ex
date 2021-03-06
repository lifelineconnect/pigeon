defprotocol Pigeon.Configurable do
  @type sock :: {:sslsocket, any, pid | {any, any}}

  @doc ~S"""
  Returns worker name for config.

  ## Examples

      iex> worker_name(%Pigeon.APNS.Config{name: :test})
      :test

      iex> worker_name(%Pigeon.FCM.Config{name: :another})
      :another
  """
  @spec worker_name(any) :: atom | nil
  def worker_name(config)

  @spec connect(any) :: {:ok, sock} | {:error, String.t}
  def connect(config)

  def push_headers(config, notification, opts)

  def push_payload(config, notification, opts)

  def handle_end_stream(config, stream, notification, on_response)

  @doc ~S"""
  Schedules connection ping if necessary.

  ## Examples

      iex> schedule_ping(%Pigeon.APNS.Config{ping_period: 2})
      iex> receive do
      ...>   :ping -> "Got ping!"
      ...> after
      ...>   5000 -> "No ping received."
      ...> end
      "Got ping!"

      iex> schedule_ping(%Pigeon.FCM.Config{})
      iex> receive do
      ...>   :ping -> "Got ping!"
      ...> after
      ...>   5000 -> "No ping received."
      ...> end
      "No ping received."
  """
  @spec schedule_ping(any) :: no_return
  def schedule_ping(config)

  @doc ~S"""
  Returns whether connection should reconnect if dropped.

  ## Examples

      iex> reconnect?(%Pigeon.APNS.Config{reconnect: true})
      true

      iex> reconnect?(%Pigeon.FCM.Config{}) # always false
      false
  """
  @spec reconnect?(any) :: boolean
  def reconnect?(config)

  def close(config)
end
