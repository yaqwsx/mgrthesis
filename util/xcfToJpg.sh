#!/usr/bin/env bash

# Taken from https://stackoverflow.com/questions/630405/converting-xcf-and-other-files-using-command-line-with-gimp

{
cat <<EOF
(define (convert-xcf-to-jpeg filename outfile)
  (let* (
     (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
     (drawable (car (gimp-image-merge-visible-layers image CLIP-TO-IMAGE)))
     )
    (file-jpeg-save RUN-NONINTERACTIVE image drawable outfile outfile .9 0 0 0 " " 0 1 0 1)
    (gimp-image-delete image) ; ... or the memory will explode
    )
)

(gimp-message-set-handler 1) ; Messages to standard output
EOF

echo "(gimp-message \"$i\")"
echo "(convert-xcf-to-jpeg \"$1\" \"$2\")"
echo "(gimp-quit 0)"

} | gimp -i -b -