# required toastr library

class @UI
  # NOTIFICATIONS

  @showMessage: (type, message) =>
    toastr[type](message);

  @info: (message) =>
    this.showMessage('info', message);

  @success: (message) =>
    this.showMessage('success', message);

  @warn: (message) =>
    this.showMessage('warning', message);

  @error: (message) =>
    this.showMessage('error', message);



  # DIALOGS

  @confirm: (question) =>
    confirm(question)

  @askYesNo: (question) =>
    # todo: Replace raw confirm with https://craftpip.github.io/jquery-confirm/#buttons
    confirm(question)
