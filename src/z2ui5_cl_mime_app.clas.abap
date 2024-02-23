CLASS z2ui5_cl_mime_app DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.
    DATA classname TYPE string VALUE `zcl_mime_cloud_test`.
    DATA type TYPE string VALUE `javascript`.
    DATA methodname TYPE string VALUE 'z2ui5_if_mime_container~container'.
    DATA file TYPE string.
    DATA mt_type_help TYPE z2ui5_if_types=>ty_t_name_value.
    DATA mt_class_help TYPE z2ui5_if_types=>ty_t_name_value.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_mime_app IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      mt_type_help = VALUE #( FOR row IN z2ui5_cl_util=>source_get_file_types( ) ( n = to_upper( shift_right( shift_left( row ) ) )  v = shift_right( shift_left( row ) ) ) ).
      mt_class_help = VALUE #( FOR row IN z2ui5_cl_util=>rtti_get_classes_impl_intf( |Z2UI5_IF_MIME_CONTAINER| ) ( n = row v = row ) ).
      classname = VALUE #( mt_class_help[ 1 ]-n OPTIONAL ).

      DATA(view) = z2ui5_cl_xml_view=>factory( ).
      DATA(cont) = view->shell(
            )->page(
                    title          = 'abap2UI5 - Cloud MIME Fake'
                    navbuttonpress = client->_event( val = 'BACK' check_view_destroy = abap_true )
                    shownavbutton  = abap_true
                )->header_content(
                    )->link(
                        text = 'Repository on GitHub'
                        href = `https://github.com/oblomov-dev/a2UI5_cloud_mime_fake`
                        target = '_blank'
                )->get_parent(
                )->simple_form( editable = abap_true
                    )->content( 'form' ).
*                        )->title( 'Classname'
      DATA(input2) = cont->label( 'Classname'
      )->input(
            value = client->_bind_edit( classname )
            width = `30%`
              suggestionrows  = client->_bind( mt_class_help )
       showsuggestion  = abap_true
            )->get( ).

      input2->suggestion_columns(
*        )->Column(  )->label( text = 'Name' )->get_parent(
 )->column(  )->label( text = 'Value' ).

      input2->suggestion_rows(
          )->column_list_item(
              )->label( text = '{V}' ).

      cont->label( `Methodname` )->input(
            value = methodname
            enabled = abap_false  width = `30%`
      )->label( `Source Code`
      )->link(
              text = 'Show...'
              href = |{ client->get( )-s_config-origin }/sap/bc/adt/oo/classes/{ client->_bind_edit( classname ) }/source/main|
              target = '_blank'
      )->label( `Type` ).
      DATA(input) = cont->input( value =  client->_bind_edit( type )  width = `20%`
               suggestionrows  = client->_bind( mt_type_help )
       showsuggestion  = abap_true
       )->get( ).

      input->suggestion_columns(
*        )->Column(  )->label( text = 'Name' )->get_parent(
        )->column(  )->label( text = 'Value' ).

      input->suggestion_rows(
          )->column_list_item(
*            )->label( text = '{N}'
              )->label( text = '{V}' ).

      cont->label(
                 )->button(
                     text  = 'load...'
                     press = client->_event( val = 'ON_LOAD' )  width = `10%`
       )->get_parent( )->get_parent(
       )->code_editor(
         type  =  client->_bind_edit( type )
         value = client->_bind_edit( file ) editable = abap_false
       ).

      client->view_display( cont->stringify( ) ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'ON_LOAD'.

        file = z2ui5_cl_util=>source_get_method(
          iv_classname  = classname
          iv_methodname = methodname ).

*        file = z2ui5_cl_util=>source_method_to_file( lt_source ).

        client->view_model_update( ).
        client->message_toast_display( |File loaded| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack  ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
