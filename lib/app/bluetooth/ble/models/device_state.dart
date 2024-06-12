enum DeviceState {
  /// Currently establishing a connection.
  connecting,

  /// Connection is established.
  connected,

  /// Terminating the connection.
  disconnecting,

  /// Device is disconnected.
  disconnected,

  /// Device is enableNotification.
  enableNotification,

  /// Device is channelsuccessed.
  channelSuccessed
}
