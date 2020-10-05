# pulp_redhat_cert_concat
The purpose of this script is to automate the RedHat feed expiring every 3 months for the Pulp repository synchronization.

When you register a system to RedHat, subscription-manager seems to automate the new certificate downloads. This script takes the entitlement PEM files, concatenates them together, copies the concatenated file to a destination of your choosing, and updates the relevant RHEL feeds in pulp.

NOTE: you may need to edit my grep for what you require.
