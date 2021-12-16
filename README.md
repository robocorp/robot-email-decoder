# robot-email-decoder

This robot is intended to be the first step in a multi step process that is triggered by incoming email. Robot will decode the raw email data from the input work item and provide it in more convenient format for following steps to use:

 - Email file attachments are converted to files
 - Email headers are provided as key-value-pairs e.g.
   - `From`
   - `To`
   - `Date`
   - `Message-ID`
   - `Subject`
 - Email body is available as `Body`
 - Original raw data is available as `rawEmail`
 - Additional `Has-Attachments` flag is also available 

## Installation

Configure first step in your process to use robot from public git repository in: https://github.com/robocorp/robot-email-decoder.git
