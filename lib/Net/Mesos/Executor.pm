package Net::Mesos::Executor;
use Moo;
use strict;
use warnings;

with 'Net::Mesos::Role::Executor';

sub registered {}
sub reregistered {}
sub disconnected {}
sub launchTask {}
sub killTask {}
sub frameworkMessage {}
sub shutdown {}
sub error {}


=head1 Name

Net::Mesos::Executor - base class for Mesos executors

=head1 Methods

=over 4

=item registered($driver, $executorInfo, $frameworkInfo, $slaveInfo)

=item reregistered($driver, $slaveInfo)

=item disconnected($driver)

=item launchTask($driver, $task)

=item killTask($driver, $taskId)

=item frameworkMessage($driver, $message)

=item shutdown($driver)

=item error($driver, $message)

=back

=cut

1;
