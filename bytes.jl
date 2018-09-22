# this should be a byte file

function str_to_bytes(s::String)
    r_val = UInt8[]
    for c in s
        push!(r_val, bytes(c))
    end
    return r_val
end

function strToUInt128s!(s::String)
    big_bytes = UInt128[]
    temp = UInt128(0)
    count = 0
    for c in s
        count += 1
        @show temp = temp << 8
        temp = temp | UInt8(c)

        if count == 16
            push!(big_bytes, temp)
            temp = UInt128(0)
            count= 0
        end
    end
    if count < 16 && temp != 0
        push!(big_bytes, temp)
    end
    return big_bytes
end

function UInt128sToStr(Us::Array{UInt128})
    str = UInt8[]
    subtract = 0
    for i in Us
        # push two bytes left until not zero
        while ((i & (UInt128(0xff) << 120)) >> 120) == 0
            i = i << 8
            subtract += 1
        end
        for c in 1:(16 - subtract)
            ch = (i & (UInt128(0xff) << 120)) >> 120
            i = i << 8
            push!(str, ch)
        end
        subtract = 0
    end
    str = String(str)
    return str
end

function Pad_Encryption(US::Array{UInt128}, key = nothing)
    #  if key does not exist then create one
    if key == nothing
        key = rand(UInt128, length(US))
    end

    return (US .+ key, key)
end

function Pad_Decryption(US::Array{UInt128}, key)
    return US .- key
end



s = "hello im here this is a sentence this is an even longer sentence"
@show x = strToUInt128s!(s)
@show UInt128sToStr(x)
@show e = Pad_Encryption(x)
@show UInt128sToStr(Pad_Decryption(e[1],e[2]))
