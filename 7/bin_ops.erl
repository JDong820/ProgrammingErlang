-module(bin_ops).
-export([reverse_binary/1, term_to_packet/1, test_reverse_binary/0, test_term_packet_conversion/0, test_all/0, reverse_byte/1, reverse_bits/1]).

%
% tests
%

test_all() ->
    test_reverse_binary(),
    test_term_packet_conversion(),
    test_reverse_bits(),
    all_tests_passed.

test_reverse_binary() -> % bytewise reversal
    <<3, 2, 1>> = reverse_binary(<<1,2,3>>),
    <<1>> = reverse_binary(<<1>>),
    <<>> = reverse_binary(<<>>),
    reverse_binary_tests_passed.

test_term_packet_conversion() ->
    Test = term_to_binary([1]),
    <<5:32/integer, Test:5/binary>> = term_to_packet([1]),
    [1] = packet_to_term(<<5:32/integer, Test/binary>>),
    TestPacket = term_to_packet(["hello", world]),
    ["hello", world] = packet_to_term(TestPacket),
    term_packet_conversion_tests_passed.

test_reverse_bits() ->
    <<16#10>> = reverse_bits(<<1>>),
    <<2#01010101>> = reverse_bits(<<2#10101010>>),
    <<16#ff4f>> = reverse_bits(<<16#f2ff>>),
    reverse_bits_tests_passed.

%
% helper functions
%

reverse_byte(Byte) ->
    <<B1:1, B2:1, B3:1, B4:1, B5:1, B6:1, B7:1, B8:1>> = Byte,
    Reversed = <<B8:1, B7:1, B6:1, B5:1, B4:1, B3:1, B2:1, B1:1>>,
    <<Inside:8/integer>> = Reversed, % help
    Inside.

%
% exported functions
%

reverse_bits(Binary) -> % Reverse the bits in a binary.
    % << <<(reverse_byte(<<B>>))>> ||
    << <<(reverse_byte(<<B>>))>> ||
      <<B>> <= reverse_binary(Binary)>>.
    % <<Bit || BitIndex <= lists:seq(1, Size),
    %          <<_:BitIndex-1/bits, Bit:1/bits, _:Size-BitIndex/bits>> >>.
    %          interesting, but not what we want

reverse_binary(B) ->
    list_to_binary(lists:reverse(binary_to_list(B))).

term_to_packet(Term) ->
    Packet = term_to_binary(Term),
    <<(byte_size(Packet)):32/integer, Packet/binary>>.

packet_to_term(Packet) ->
    <<Size:32/integer, Data:Size/bytes>> = Packet,
    binary_to_term(Data).
