# == Defined type: icinga2::object::apply_service_to_host
#
# This is a defined type for Icinga 2 apply objects that apply services to hosts.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-service
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::apply_service_to_host (
  $object_servicename = $name,
  $template_to_import = 'generic-service',
  $display_name = $name,
  $assign_where = undef,
  $ignore_where = undef,
  $groups = [],
  $vars = {},
  $check_command = undef,
  $max_check_attempts = undef,
  $check_period = undef,
  $check_interval = undef,
  $retry_interval = undef,
  $enable_notifications = undef,
  $enable_active_checks = undef,
  $enable_passive_checks = undef,
  $enable_event_handler = undef,
  $enable_flap_detection = undef,
  $enable_perfdata = undef,
  $event_command = undef,
  #flapping_threshold is defined as a percentage, eg. 10%, 50%, etc.
  $flapping_threshold = undef,
  $volatile = undef,
  $notes = undef,
  $notes_url = undef,
  $action_url = undef,
  $icon_image = undef,
  $icon_image_alt = undef,
  $target_dir        = '/etc/icinga2/conf.d',
  $target_file_name  = "${name}.conf",
  $target_file_owner = 'root',
  $target_file_group = 'root',
  $target_file_mode  = '0644'
) {

  #Do some validation of the class' parameters:
  validate_string($object_servicename)
  validate_string($template_to_import)
  validate_array($groups)
  validate_hash($vars)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)


  file {"${target_dir}/${target_file_name}":
    ensure  => file,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_apply_service_to_host.conf.erb'),
    notify  => Service['icinga2'],
  }

}
