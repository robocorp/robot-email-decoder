*** Settings ***
Library  RPA.Robocorp.WorkItems
Library  RPA.Email.ImapSmtp
Library  RPA.FileSystem


*** Tasks ***
Decode Email to Work Item
    ${payload}=    Get work item payload
    ${message}   Evaluate  email.message_from_string($payload["rawEmail"])  modules=email
    ${body}  ${has_attachments}   Get Decoded Email Body    ${message}

    Create output work item
    ${headers}=  Evaluate  dict($message._headers)
    Set Work Item Payload    ${headers}
    Set work item variables
    ...  rawEmail=${payload}[rawEmail]
    ...  Has-Attachments=${has_attachments}  
    ...  Body=${body}

    ${email}    Create Dictionary  Message=${message}  

    IF    ${has_attachments}
        Create Directory  attachments
        Save Attachment
        ...    ${email}
        ...    target_folder=attachments
        ...    overwrite=True
        
        ${files}=  List Files In Directory  attachments
        FOR  ${file}  IN  @{files}
            Add work item file    ${file}
        END
    END

    Save work item


