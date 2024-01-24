INTERFACE z2ui5_if_mime_container
  PUBLIC.

  TYPES:
    BEGIN OF ty_s_metadata,
      name   TYPE string,
      format TYPE string,
      descr  TYPE string,
    END OF ty_s_metadata.

  METHODS get_metadata
    RETURNING
      VALUE(result) TYPE ty_s_metadata.

  "! Dummy Container, filled with file data as comments, don't use this!
  METHODS container.

ENDINTERFACE.
