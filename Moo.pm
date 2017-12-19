package PlSense::Plugin::PPIBuilder::Moo;

use parent qw{ PlSense::Plugin::PPIBuilder };
use strict;
use warnings;
use Class::Std;
use List::AllUtils qw{ first };
use PlSense::Logger;
use PlSense::Util;
use PlSense::Symbol::Method;
use PlSense::Entity::Reference;
use PlSense::Entity::Hash;
use PlSense::Entity::Null;
use feature qw(say);
{

    sub other_statement
    {
        my ($self, $mdl, $mtd, $stmt) = @_;

        # if ($stmt->isa('PPI::Statement')) {
        #     use Data::Printer;
        #     p $stmt;
        # }
        if (2 <= $stmt->children)
        {
            my $first_token = $stmt->child(0);
            if (   defined $first_token
                && $first_token->isa('PPI::Token::Word')
                && ($first_token->literal eq 'has' || $first_token->literal eq 'option'))
            {
                my $mtdnm = $first_token->next_sibling->literal;  #method name

                my $public = ($mtdnm !~ /^_/);

                my $mtd = PlSense::Symbol::Method->new(
                    {name => $mtdnm, module => $mdl, publicly => $public, privately => !$public});
                $mdl->set_method($mtdnm, $mtd);
            }
            return;
        }
    }
}

1;

__END__
