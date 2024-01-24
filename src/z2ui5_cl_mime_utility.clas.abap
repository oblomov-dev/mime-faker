CLASS z2ui5_cl_mime_utility DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_name_val,
        n TYPE string,
        v TYPE string,
      END OF ty_name_val.
    TYPES ty_t_name_val TYPE STANDARD TABLE OF ty_name_val WITH EMPTY KEY.

    CLASS-METHODS get_classes_impl_intf
      IMPORTING
        !val          TYPE clike
      RETURNING
        VALUE(result) TYPE ty_t_name_val.

    CLASS-METHODS get_file_types
      RETURNING
        VALUE(result) TYPE ty_t_name_val.

    CLASS-METHODS get_method_source_code
      IMPORTING
        class         TYPE string
        method        TYPE string
      RETURNING
        VALUE(result) TYPE string.

    CLASS-METHODS trans_source_code_to_file
      IMPORTING
        it_source     TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.

    CLASS-METHODS trans_file_to_source_code
      IMPORTING
        it_file       TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_mime_utility IMPLEMENTATION.

  METHOD get_method_source_code.

*    DATA lt_source TYPE string_table.
*    DATA(lv_name) = CONV char120( class && `=========CP` ).
*    DATA(lv_name) = sy-repid.
*    lv_name = shift_right( val = lv_name sub = `CP` ) && `CM`.

*    READ REPORT sy-repid INTO lt_source.

    DATA(lt_source) = lcl_read_report=>main( class ).
    DATA(lt_source_result) = VALUE string_table( ).
    DATA(lv_check_method) = abap_false.
    LOOP AT lt_source INTO DATA(lv_source).

      IF lv_source CS `ENDMETHOD.`.
        lv_check_method = abap_false.
      ENDIF.

      IF lv_source CS `METHOD z2ui5_if_mime_container~container.`.
        lv_check_method = abap_true.
        CONTINUE.
      ENDIF.

      IF lv_check_method = abap_true.
        INSERT lv_source+1 INTO TABLE lt_source_result.
      ENDIF.

    ENDLOOP.


    LOOP AT lt_source_result INTO lv_source.

    result = result && lv_source && cl_abap_char_utilities=>newline.

    ENDLOOP.

    result = shift_right( val = result sub = cl_abap_char_utilities=>newline ).
*    DATA(lo_class) = xco_cp_abap=>class( CONV #( class ) ).
*    r_header = lo_class->implementation->method( CONV #( method ) )->content( )->get_source( ).



  ENDMETHOD.


  METHOD trans_source_code_to_file.

    LOOP AT it_source ASSIGNING FIELD-SYMBOL(<source>).
      INSERT <source>+1 INTO TABLE result.
    ENDLOOP.

  ENDMETHOD.

  METHOD trans_file_to_source_code.

    LOOP AT it_file ASSIGNING FIELD-SYMBOL(<file>).
      INSERT `*` && <file> INTO TABLE result.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_classes_impl_intf.

    TRY.

        DATA obj TYPE REF TO object.
        CALL METHOD ('XCO_CP_ABAP')=>interface
          EXPORTING
            iv_name      = val
          RECEIVING
            ro_interface = obj.

        FIELD-SYMBOLS <any> TYPE any.
        ASSIGN obj->('IF_XCO_AO_INTERFACE~IMPLEMENTATIONS') TO <any>.
        obj = <any>.

        ASSIGN obj->('IF_XCO_INTF_IMPLEMENTATIONS_FC~ALL') TO <any>.
        obj = <any>.

        CALL METHOD obj->('IF_XCO_INTF_IMPLEMENTATIONS~GET').

        DATA lt_implementation_names TYPE string_table.
        CALL METHOD obj->('IF_XCO_INTF_IMPLEMENTATIONS~GET_NAMES')
          RECEIVING
            rt_names = lt_implementation_names.

        result = VALUE #( FOR row IN lt_implementation_names ( n = to_upper( row  ) v = row  ) ).

      CATCH cx_sy_dyn_call_illegal_class.

        TYPES:
          BEGIN OF ty_s_impl,
            clsname    TYPE c LENGTH 30,
            refclsname TYPE c LENGTH 30,
          END OF ty_s_impl.
        DATA lt_impl TYPE STANDARD TABLE OF ty_s_impl WITH DEFAULT KEY.

        TYPES:
          BEGIN OF ty_s_key,
            intkey TYPE c LENGTH 30,
          END OF ty_s_key.
        DATA ls_key TYPE ty_s_key.
        ls_key-intkey = val.

        DATA(lv_fm) = `SEO_INTERFACE_IMPLEM_GET_ALL`.
        CALL FUNCTION lv_fm
          EXPORTING
            intkey       = ls_key
          IMPORTING
            impkeys      = lt_impl
          EXCEPTIONS
            not_existing = 1
            OTHERS       = 2.

        LOOP AT lt_impl REFERENCE INTO DATA(lr_impl).
          INSERT VALUE #( n = to_upper( lr_impl->clsname  ) v = lr_impl->clsname  ) INTO TABLE result.
        ENDLOOP.

    ENDTRY.

  ENDMETHOD.

  METHOD get_file_types.

    DATA(lv_types) = `abap, abc, actionscript, ada, apache_conf, applescript, asciidoc, assembly_x86, autohotkey, batchfile, bro, c9search, c_cpp, cirru, clojure, cobol, coffee, coldfusion, csharp, css, curly, d, dart, diff, django, dockerfile, ` &&
`dot, drools, eiffel, yaml, ejs, elixir, elm, erlang, forth, fortran, ftl, gcode, gherkin, gitignore, glsl, gobstones, golang, groovy, haml, handlebars, haskell, haskell_cabal, haxe, hjson, html, html_elixir, html_ruby, ini, io, jack, jade, java, ja` &&
`vascri` &&
`pt, json, jsoniq, jsp, jsx, julia, kotlin, latex, lean, less, liquid, lisp, live_script, livescript, logiql, lsl, lua, luapage, lucene, makefile, markdown, mask, matlab, mavens_mate_log, maze, mel, mips_assembler, mipsassembler, mushcode, mysql, ni` &&
`x, nsis, objectivec, ocaml, pascal, perl, pgsql, php, plain_text, powershell, praat, prolog, properties, protobuf, python, r, razor, rdoc, rhtml, rst, ruby, rust, sass, scad, scala, scheme, scss, sh, sjs, smarty, snippets, soy_template, space, sql,` &&
` sqlserver, stylus, svg, swift, swig, tcl, tex, text, textile, toml, tsx, twig, typescript, vala, vbscript, velocity, verilog, vhdl, wollok, xml, xquery, terraform, slim, redshift, red, puppet, php_laravel_blade, mixal, jssm, fsharp, edifact,` &&
` csp, cssound_score, cssound_orchestra, cssound_document`.
    SPLIT lv_types AT ',' INTO TABLE DATA(lt_types).

    result = VALUE #( FOR row IN lt_types ( n = to_upper( shift_right( shift_left( row ) ) )  v = shift_right( shift_left( row ) ) ) ).

  ENDMETHOD.

ENDCLASS.
