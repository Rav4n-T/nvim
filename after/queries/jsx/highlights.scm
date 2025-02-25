;; extends

((jsx_attribute
        (property_identifier) @att_name (#any-of? @att_name "className" "d")
        (string (string_fragment) @class_value) (#set! @class_value conceal "…")
        ))

((jsx_attribute
        (property_identifier) @att_name (#eq? @att_name "className")
        (jsx_expression
          (template_string (string_fragment) @string-fragment @class_value) (#set! @class_value conceal "…"))
))

