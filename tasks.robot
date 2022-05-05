*** Settings ***
Library    Collections
Library    RPA.Email.ImapSmtp
Library    RPA.FileSystem
Library    RPA.Robocorp.WorkItems


*** Variables ***
${ATTACHMENTS_DIR}    ${OUTPUT_DIR}${/}attachments


*** Tasks ***
Decode Raw Email To Work Item
    # With "Parse email" Control Room configuration option disabled.
    ${parsed_email} =    Get Work Item Variable    parsedEmail
    Log Dictionary    ${parsed_email}
    Log To Console    ${parsed_email}[Body]
    
    IF    ${parsed_email}[Has-Attachments]
        ${raw_email} =    Get Work Item Variable    rawEmail
        ${message} =    Evaluate    email.message_from_string($raw_email)     modules=email
        Create Directory    ${ATTACHMENTS_DIR}
        Save Attachment
        ...    ${message}
        ...    target_folder=${ATTACHMENTS_DIR}
        ...    overwrite=${True}
        
        ${files} =    List Files In Directory    ${ATTACHMENTS_DIR}
        Create Output Work Item
        FOR  ${file}  IN  @{files}
            Add Work Item File    ${file}
        END
        Save work item
    END

Decode Parsed Email To Work Item
    # With "Parse email" Control Room configuration option enabled.
    ${email_parsed} =    Get Work Item Variable    email
    Log Dictionary    ${email_parsed}
    Log To Console    ${email_parsed}[body]

    # E-mail attachments are already available as Work Item files.
    ${files} =    List Work Item Files
    Log List    ${files}
