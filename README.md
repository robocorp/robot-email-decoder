# robot-email-decoder

This robot is intended to be the first step in a multi step process that is triggered
by an incoming e-mail.

### "Parse email" enabled in Control Room

With this configuration option enabled, your robot will automatically get the parsed
version of the e-mail into the `email` input Work Item variable. Place where you can
find the `email[body]` additionally parsed content as well. (auto detects JSON/YAML
format)

The e-mail file attachments can be discovered and retrieved as normal input Work Item
files. Additionally, you can find two other *special* files:
- __mail.html: the HTML content of the sent e-mail
- __raw_mail: the raw data of the entire e-mail

For backwards compatibility, you'll still get the old deprecated `parsedEmail` payload
variable, but it contains the `parsedEmail[Body]` only, as the rest is found in the
recommended to be used `email` variable.

### Raw e-mail is **deprecated**

With "Parse email" unchecked, the robot will decode the raw e-mail data from the input
Work Item and provide it in a more convenient format for the following steps to use:

  - E-mail file attachments are converted to files (in the output Work Item)
  - E-mail headers are provided as key-value pairs right in the `parsedEmail` payload
    variable, e.g.:
    - `From`
    - `To`
    - `Date`
    - `Message-ID`
    - `Subject`
    - `Has-Attachments`
  - E-mail body is additionally parsed and available as `parsedEmail[Body]`
  - Original raw data is still available as `rawEmail`

## Installation

Configure the first step of your process to use the robot from the public Git
[repository](https://github.com/robocorp/robot-email-decoder.git) and as task, the
recommended `Decode Parsed Email To Work Item` one.

Then test it by starting the process with an e-mail. We recommend enabling the "Parse
email" configuration option in Control Room, more details in this
[article](https://robocorp.com/docs/control-room/attended-or-unattended/email-trigger).
