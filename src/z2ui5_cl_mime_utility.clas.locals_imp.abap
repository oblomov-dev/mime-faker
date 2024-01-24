*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_read_report DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS main
      IMPORTING
        classname     TYPE clike
      RETURNING
        VALUE(result) TYPE string_table.

ENDCLASS.

CLASS lcl_read_report IMPLEMENTATION.

  METHOD main.

    DATA cifkey TYPE seoclskey.
*  print(1).

    DATA lt_source TYPE string_table.
    DATA:
      clstype     TYPE seoclstype,
      source      TYPE seop_source_string,
      pool_source TYPE seop_source_string,
      source_line TYPE LINE OF seop_source_string,
      tabix       TYPE sytabix,
      includes    TYPE seop_methods_w_include,
      include     TYPE seop_method_w_include,
      cifref      TYPE REF TO if_oo_clif_incl_naming,
      clsref      TYPE REF TO if_oo_class_incl_naming,
      intref      TYPE REF TO if_oo_interface_incl_naming.

    DATA: l_string TYPE string.

    cifkey = classname.

    CALL METHOD cl_oo_include_naming=>get_instance_by_cifkey
      EXPORTING
        cifkey = cifkey
      RECEIVING
        cifref = cifref
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc <> 0.
      MESSAGE e003(oo) WITH cifkey.
    ENDIF.

    CASE cifref->clstype.
      WHEN seoc_clstype_class.
        clsref ?= cifref.
        READ REPORT clsref->class_pool
          INTO pool_source.
        LOOP AT pool_source INTO source_line.
          IF source_line CS 'CLASS-POOL'
            OR source_line CS 'class-pool'.
            INSERT source_line INTO TABLE lt_source..
            tabix = sy-tabix.
            EXIT.
          ENDIF.
        ENDLOOP.
        SKIP.
        READ REPORT clsref->locals_old
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source.
          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          SKIP.
        ENDIF.
        READ REPORT clsref->locals_def
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          SKIP.
        ENDIF.
        READ REPORT clsref->locals_imp
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          SKIP.
        ENDIF.
        READ REPORT clsref->macros
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          SKIP.
        ENDIF.
        READ REPORT clsref->public_section
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        SKIP.
        READ REPORT clsref->protected_section
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        SKIP.
        READ REPORT clsref->private_section
          INTO source.
        LOOP AT source
          INTO source_line.
          IF source_line NS '*"*'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.
        CONCATENATE 'CLASS' cifkey 'IMPLEMENTATION' INTO l_string SEPARATED BY space.
        LOOP AT pool_source
          FROM tabix
          INTO source_line.
          IF source_line CS 'ENDCLASS'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
          IF source_line CS l_string.
            SKIP.
            INSERT source_line INTO TABLE lt_source..
            tabix = sy-tabix.
            EXIT.
          ENDIF.
        ENDLOOP.
* method implementation
        includes = clsref->get_all_method_includes( ).
        LOOP AT includes
          INTO include.
          READ REPORT include-incname
            INTO source.
          SKIP.
          LOOP AT source
            INTO source_line.
            INSERT source_line INTO TABLE lt_source..
          ENDLOOP.
        ENDLOOP.
        LOOP AT pool_source
          FROM tabix
          INTO source_line.
          IF source_line CS 'ENDCLASS'.
            INSERT source_line INTO TABLE lt_source..
          ENDIF.
        ENDLOOP.


      WHEN seoc_clstype_interface.
        intref ?= cifref.
        READ REPORT intref->interface_pool
          INTO source.
        LOOP AT source INTO source_line.
          INSERT source_line INTO TABLE lt_source..
        ENDLOOP.
        SKIP.
        READ REPORT intref->public_section
          INTO source.
        LOOP AT source INTO source_line.
          INSERT source_line INTO TABLE lt_source..
        ENDLOOP.
        SKIP.

    ENDCASE.

    result = lt_source.
  ENDMETHOD.

ENDCLASS.
