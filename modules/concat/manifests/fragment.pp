# Puts a file fragment into a directory previous setup using concat
# 
# OPTIONS:
#   - target    The file that these fragments belong to
#   - content   If present puts the content into the file
#   - source    If content was not specified, use the source
#   - order     By default all files gets a 10_ prefix in the directory
#               you can set it to anything else using this to influence the
#               order of the content in the file
#   - ensure    Present/Absent
#   - mode      Mode for the file
#   - owner     Owner of the file
#   - group     Owner of the file
define concat::fragment($target, $content='', $source='', $order=10, $ensure = "present", $mode = 0644, $owner = root, $group = root) {
    $safe_target_name = regsubst($target, '/', '_', 'G')
    $concatdir = $concat::setup::concatdir
    $fragdir = "${concatdir}/${safe_target_name}"

    # if content is passed, use that, else if source is passed use that
    case $content {
             "": { 
                    case $source {
                             "": { crit("No content or source specified")  }
                        default: { File{ source => $source } }
                    }
                 }
        default: { File{ content => $content } }
    }

    file{"${fragdir}/fragments/${order}_${name}":
        mode   => $mode,
        owner  => $owner,
        group  => $group,
        ensure => $ensure,
        alias  => "concat_fragment_${name}",
        notify => Exec["concat_${target}"]
    }
}

# vi:tabstop=4:expandtab:ai
