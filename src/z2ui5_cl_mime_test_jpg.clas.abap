CLASS z2ui5_cl_mime_test_jpg DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_mime_container.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_mime_test_jpg IMPLEMENTATION.
  METHOD z2ui5_if_mime_container~container.
*iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==
  ENDMETHOD.

  METHOD z2ui5_if_mime_container~get_metadata.

    result = VALUE #( format = `data:image/png;base64` ).

  ENDMETHOD.

ENDCLASS.
