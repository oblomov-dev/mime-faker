CLASS z2ui5_cl_mime_test_json DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_mime_container.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_MIME_TEST_JSON IMPLEMENTATION.


  METHOD z2ui5_if_mime_container~container.
*{
*    "glossary": {
*        "title": "example glossary",
*        "GlossDiv": {
*            "title": "S",
*            "GlossList": {
*                "GlossEntry": {
*                    "ID": "SGML",
*                    "SortAs": "SGML",
*                    "GlossTerm": "Standard Generalized Markup Language",
*                    "Acronym": "SGML",
*                    "Abbrev": "ISO 8879:1986",
*                    "GlossDef": {
*                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
*                        "GlossSeeAlso": ["GML", "XML"]
*                    },
*                    "GlossSee": "markup"
*                }
*            }
*        }
*    }
*}
 ENDMETHOD.


  METHOD z2ui5_if_mime_container~get_metadata.

    result = VALUE #( format = `data:image/png;base64` ).

  ENDMETHOD.
ENDCLASS.
