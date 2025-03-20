package com.mock.taka.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EmailDetail {

    // Class data members
    private String recipient;
    private String msgBody;
    private String subject;
    private String attachment;
}
