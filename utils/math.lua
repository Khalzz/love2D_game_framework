function lerp(a, b, t)
    return a + (b - a) * t
end

return {
    lerp = lerp
}