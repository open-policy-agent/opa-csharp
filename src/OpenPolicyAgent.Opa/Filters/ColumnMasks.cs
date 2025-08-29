

using System.Collections.Generic;
using Newtonsoft.Json;
using OpenPolicyAgent.Ucast.Linq;

namespace OpenPolicyAgent.Opa.Filters;

/// <summary>
/// Wrapper type for the column masking rule objects EOPA generates alongside data filtering results.
/// </summary>
/// <remarks>See: <see href="https://github.com/open-policy-agent/eopa/blob/main/docs/data-filtering/explanation/column-masks.md"/></remarks>
public class ColumnMasks : Dictionary<string, Dictionary<string, MaskingFunc>>
{
    public ColumnMasks() : base() { }
    public ColumnMasks(int capacity) : base(capacity) { }

    [JsonConstructor]
    public ColumnMasks(IDictionary<string, Dictionary<string, MaskingFunc>> dictionary)
        : base(dictionary) { }

    public override string ToString()
    {
        return JsonConvert.SerializeObject(this);
    }
}